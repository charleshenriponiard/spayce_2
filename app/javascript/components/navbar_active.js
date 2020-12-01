const navbarActive = () => {
  const path = window.location.pathname
  const navLinks = document.querySelectorAll('.nav-item-activable')
  if (navLinks) {
    navLinks.forEach(link => link.classList.remove('nav-active'))
    if (path.length < 4 || path.split('/').includes('confirmation')) {
      navLinks[0].classList.add('nav-active')
    } else if (path.split('/').includes('projects') && !path.split('/').includes('clients')) {
      navLinks[1].classList.add('nav-active')
    } else if (path.includes('/users/edit')) {
      navLinks[2].classList.add('nav-active')
    }
  }
}

export { navbarActive }
