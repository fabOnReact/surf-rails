import { tideOptions } from '../lib/tideChart'
import Tide from '../lib/tide'
import { renderChart, waveOptions } from '../lib/waveChart'

export function router() {
  var location_path = event.currentTarget.location.pathname 
  switch(location_path) {
    case '/':
        containerStyle();
        setLocation()
        break;
    case '/posts':
    case '/users/sign_in':
    case '/users/sign_up':
        getLocation();
        break;
  }

  if (location_path.match(/posts\/[0-9][0-9]/)) { 
    var forecast = $('#forecast-data').data('forecast')
    var tideData = forecast.tide
    appendTideData(tideData, '#tideTable')
    var hours = forecast.hours.map((time) => new Date(time).getHours())
    var days = forecast.days.map((time) => new Date(time).getHours())
    renderChart('line', forecast.tides, hours, 'tideChart', ["rgb(0, 128, 0)"], tideOptions)
    renderChart('bar', forecast.waves, days, 'waveChart', [], waveOptions)
  }
}

function appendTideData(data, target) {
  var $target = $(target)
  if ($target[0].childElementCount != 0) { return }
  Object.keys(data).forEach(function(key) {
    var tide = new Tide(data[key])
    $target.append(tide.row)
  });
}
