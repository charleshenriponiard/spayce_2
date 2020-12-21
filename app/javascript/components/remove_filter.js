const triggerFilter = () => {
  const search = document.getElementById('search')
  const close = document.querySelector('.close')
  if(search && close) {
    search.addEventListener('input', event => {
      if(event.target.value !== "") {
        close.classList.add('active')
      } else {
        close.classList.remove('active')
      }
    })
  }
}
export { triggerFilter }
