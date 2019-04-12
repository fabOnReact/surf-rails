export default function getLocation(){
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    alert('Geolocation is not supported by this browser.')
  }
}

function showPosition(position) {
  let lat = position.coords.latitude
  let long = position.coords.longitude
  let href = `/posts?latitude=${lat}&longitude=${long}`
  let link = `<a href=${href} class='btn btn-success btn-lg px-4'>Try it!</a>`
  $('#posts_path').append(link)
}
