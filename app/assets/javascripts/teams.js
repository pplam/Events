function listenToJoinBtns() {
  const joinButtons = document.getElementsByClassName('join')
  Array.prototype.forEach.call(joinButtons, (btn) => {
    btn.addEventListener('click', (event) => {
      btn.classList.remove('btn-success')
      btn.className += ' btn-secondary disabled'
    })
  })
}
