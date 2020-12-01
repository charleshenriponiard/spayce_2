const copyToClipboard = () => {
  function createNode(text) {
      var node = document.createElement('pre');
      node.style.width = '1px';
      node.style.height = '1px';
      node.style.position = 'fixed';
      node.style.top = '5px';
      node.textContent = text;
      return node;
    }

    function copyNode(node) {
      document.execCommand("copy")
      navigator.clipboard.writeText(`http://${node.innerText}`)
    }

  function copyText(text) {
      var node = createNode(text);
      document.body.appendChild(node);
      copyNode(node);
      document.body.removeChild(node);
    }

  const button = document.getElementById("clipborad-button");
  const copyButton = () => {
    copyText(button.dataset.attribute);
    button.innerHTML = button.dataset.copied;
  }

  if (button) {
    document.querySelector("#clipborad-button").addEventListener("click", copyButton);
  }
}

export { copyToClipboard }
