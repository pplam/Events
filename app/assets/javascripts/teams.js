function listenToJoinBtns() {
  const joinButtons = document.getElementsByClassName('join')
  Array.prototype.forEach.call(joinButtons, (btn) => {
    btn.addEventListener('click', (event) => {
      btn.classList.remove('button-green')
      btn.className += ' button-gray disabled'
    })
  })
}

// $(document).on("turbolinks:load", () => {
//   listenToJoinBtns()
// })
