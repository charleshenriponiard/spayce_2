import Swal from 'sweetalert2'
import { csrfToken } from "@rails/ujs";

const initSwal = () => {
  const swalButton = document.querySelector("#sweet-alert-cancel");
  if (swalButton) {
    swalButton.addEventListener('click', (e) => {
      e.preventDefault()
      Swal.fire({
        title: swalButton.dataset.title,
        text: swalButton.dataset.content,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        cancelButtonColor: '#c4c4c4',
        cancelButtonText: swalButton.dataset.cancel,
        confirmButtonText: swalButton.dataset.confirmation
      }).then(result => {
        if (result.isConfirmed) {
          fetch(swalButton.dataset.url, {
            headers: {
              "X-CSRF-Token": csrfToken()
            },
            method: swalButton.dataset.method
          }).then(() => window.location = swalButton.dataset.redirect)
        }
      })
    });
  }
};

export { initSwal }
