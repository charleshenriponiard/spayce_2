import consumer from "./consumer";

const initProjectCable = () => {
  const downloadDiv = document.getElementById('download_button');
  if (downloadDiv) {
    const id = downloadDiv.dataset.projectId;

    consumer.subscriptions.create({ channel: "ProjectChannel", id: id }, {
      received(data) {
        downloadDiv.innerHTML = data.html;
      },
    });
  }
}

export { initProjectCable };
