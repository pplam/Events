App.createLine = (data) => {
  const html = `<div class="row", style="background-color:#a65959;margin:5px;padding:0">
  <div class="col-md-2">
    ${data.createdAt}
  </div>
  <div class="col-md-10">
    <p><strong>${data.userName}</strong>  ${data.content} :  ${data.target}</p>
    <p>${data.result}</p>
  </div>
</div>`
  const div = document.createElement('div')
  div.innerHTML = html
  return div.firstChild
}

App.prependLine = (data) => {
  const html = App.createLine(data)
  const container = document.getElementById('EventContainer')
  if (container.firstChild)
    container.insertBefore(html, container.firstChild)
  else
    container.appendChild(html)
}

App.subscribeEventNotifications = () => {
  App.event_notifications = App.cable.subscriptions.create('EventNotificationsChannel', { received: App.prependLine })
}
