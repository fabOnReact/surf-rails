export const setLocation = async () => {
  let latitude = await localStorage.getItem('latitude') 
  let longitude = localStorage.getItem('longitude')
  let url = `/posts?latitude=${latitude}&longitude=${longitude}`
  $("#posts_path").attr("href", url)
}

function getLatitude() { 
}

export const getLocation = () => {
  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    alert('Geolocation is not supported by this browser.')
  }
}

function showPosition(position) {
  let coords = position.coords
  localStorage.setItem('latitude', latitude)
  localStorage.setItem('longitude', longitude)
  let $lat = `<input type='hidden' name='latitude' id='latitude' value=${coords.latitude}>`
  let $long = `<input type='hidden' name='longitude' id='longitude' value=${coords.longitude}>`
  let $hiddenInput = $lat + $long
  $("#new_user").append($hiddenInput)
}
