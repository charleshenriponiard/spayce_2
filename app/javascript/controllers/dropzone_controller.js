import Dropzone from "dropzone";
import { Controller } from "stimulus";
import { DirectUpload } from "@rails/activestorage";
import {
  getMetaValue,
  toArray,
  findElement,
  removeElement,
  insertAfter
} from "helpers";

export default class extends Controller {
  static targets = ["input"];

  connect() {
    this.dropZone = createDropZone(this);
    this.hideFileInput();
    this.bindEvents();
    Dropzone.autoDiscover = false; // necessary quirk for Dropzone error in console
    this.handleSubmitButton();
  }

  // Manually added => Disable button in no file or not completed
  handleSubmitButton = () => {
    const submitButton = document.querySelector('input[type=submit]')
    const errorArea = document.querySelector('#error-area')
    const files = document.querySelectorAll('.dz-preview')
    submitButton.disabled = true
    let status = false

    const filenames = Array.from(document.querySelectorAll('.dz-filename')).map(elt => elt.innerText)
    let unique = [...new Set(filenames)];

    if (files.length > 0) {
      status = true
      files.forEach((file) => {
        const classList = Array.prototype.slice.call(file.classList)
        if (!classList.includes('dz-success') || !classList.includes('dz-complete')) {
          status = false
        }
      })
      if (filenames.length > unique.length) {
        status = false
        errorArea.innerHTML = `<p class="text-red mb-2"><em>${errorArea.dataset.error}</em></p>`
      } else {
        errorArea.innerHTML = ''
      }
    }

    if (status) {
      submitButton.disabled = false
    }
  }

  // Private
  hideFileInput() {
    this.inputTarget.disabled = true;
    this.inputTarget.style.display = "none";
  }

  bindEvents() {
    this.dropZone.on("addedfile", file => {
      file._removeLink.innerText = file.previewElement.parentNode.dataset.remove
      setTimeout(() => {
        file.accepted && createDirectUploadController(this, file).start();
      }, 500);
      this.handleSubmitButton();
    });

    this.dropZone.on("removedfile", file => {
      file.controller && removeElement(file.controller.hiddenInput);
      this.handleSubmitButton();
    });

    this.dropZone.on("canceled", file => {
      file.controller && file.controller.xhr.abort();
      this.handleSubmitButton();
    });

    this.dropZone.on("complete", file => {
      this.handleSubmitButton();
    });
  }

  get headers() {
    return { "X-CSRF-Token": getMetaValue("csrf-token") };
  }

  get url() {
    return this.inputTarget.getAttribute("data-direct-upload-url");
  }

  get maxFiles() {
    return this.data.get("maxFiles") || 100;
  }

  get maxFileSize() {
    return this.data.get("maxFileSize") || 1000; // Mega-octets
  }

  get acceptedFiles() {
    return this.data.get("acceptedFiles");
  }

  get addRemoveLinks() {
    return this.data.get("addRemoveLinks") || true;
  }
}

class DirectUploadController {
  constructor(source, file) {
    this.directUpload = createDirectUpload(file, source.url, this);
    this.source = source;
    this.file = file;
  }

  start() {
    this.file.controller = this;
    this.hiddenInput = this.createHiddenInput();
    this.directUpload.create((error, attributes) => {
      if (error) {
        removeElement(this.hiddenInput);
        this.emitDropzoneError(error);
      } else {
        this.hiddenInput.value = attributes.signed_id;
        this.emitDropzoneSuccess();
        this.replacePreviewByPlaceholder();
      }
    });
  }

  createHiddenInput() {
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = this.source.inputTarget.name;
    insertAfter(input, this.source.inputTarget);
    return input;
  }

  directUploadWillStoreFileWithXHR(xhr) {
    this.bindProgressEvent(xhr);
    this.emitDropzoneUploading();
  }

  bindProgressEvent(xhr) {
    this.xhr = xhr;
    this.xhr.upload.addEventListener("progress", event =>
      this.uploadRequestDidProgress(event)
    );
  }

  uploadRequestDidProgress(event) {
    const element = this.source.element;
    const progress = (event.loaded / event.total) * 100;
    findElement(
      this.file.previewTemplate,
      ".dz-upload"
    ).style.width = `${progress}%`;
  }

  emitDropzoneUploading() {
    this.file.status = Dropzone.UPLOADING;
    this.source.dropZone.emit("processing", this.file);
    this.file._removeLink.innerText = this.file.previewElement.parentNode.dataset.cancel
  }

  emitDropzoneError(error) {
    this.file.status = Dropzone.ERROR;
    this.source.dropZone.emit("error", this.file, error);
    this.source.dropZone.emit("complete", this.file);
    this.file._removeLink.innerText = this.file.previewElement.parentNode.dataset.remove
  }

  emitDropzoneSuccess() {
    this.file.status = Dropzone.SUCCESS;
    this.source.dropZone.emit("success", this.file);
    this.source.dropZone.emit("complete", this.file);
    this.file._removeLink.innerText = this.file.previewElement.parentNode.dataset.remove
  }

  replacePreviewByPlaceholder() {
    const extension = this.file.name.split('.').slice(-1)[0]
    const general_type = this.file.type.split('/')
    const formats = {
      prproj : "video",
      pdf: "pdf",
      xlsx: "excel",
      xlsm: "excel",
      xls: "excel",
      xml: "excel",
      csv: "excel",
      ods: "excel",
      doc: "word",
      docm: "word",
      docx: "word",
      docx: "word",
      dot: "word",
      dotm: "word",
      dotx: "word",
      odt: "word",
      tiff: "tiff",
      ai: "illustrator",
      psd: "photoshop",
      mp4: "video",
      ppt: "ppt",
      odp: "ppt",
      pptx: "ppt",
      video: "video",
      image: "image"
    }
    const image = this.file.previewElement.childNodes[1].childNodes[0]
    if (image.currentSrc === '' || extension === 'tiff') {
      const type = formats[extension] || formats[general_type]
      image.src = `https://res.cloudinary.com/di2wcculd/image/upload/v1606990430/Spayce-default-images/logo-${type}.png`
      image.style.objectFit = 'cover'
      image.width = '120'
    }
  }
}

function createDirectUploadController(source, file) {
  return new DirectUploadController(source, file);
}

function createDirectUpload(file, url, controller) {
  return new DirectUpload(file, url, controller);
}

function createDropZone(controller) {
  return new Dropzone(controller.element, {
    url: controller.url,
    headers: controller.headers,
    maxFiles: controller.maxFiles,
    maxFilesize: controller.maxFileSize,
    acceptedFiles: controller.acceptedFiles,
    addRemoveLinks: controller.addRemoveLinks,
    autoQueue: false
  });
}
