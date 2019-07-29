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
    var $tideTable = $('#tideTable')
    var tideData = forecast.tide['extremes']
    var renderTable = $tideTable[0].childElementCount == 0 
    if (renderTable) { appendTideData(tideData, $tideTable) }
    var times = forecast.dates.map((time) => new Date(time).getHours())
    renderChart('line', forecast.tides, times, 'tideChart', ["rgb(0, 128, 0)"], tideOptions)
    renderChart('bar', forecast.waves, times, 'waveChart', [], waveOptions)
  }
}

function appendTideData(data, $target) {
  Object.keys(data).forEach(function(key) {
    var tide = new Tide(data[key])
    $target.append(tide.row)
  });
}
