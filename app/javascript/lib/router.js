import { tideOptions } from './tideChart'
import { getLocation, setLocation } from './location'
import Tide from '../lib/tide'
import { renderChart, waveOptions } from './waveChart'

export function router() {
  var location_path = event.currentTarget.location.pathname 
  switch(location_path) {
    case '/':
        // containerStyle();
        setLocation()
        break;
    case '/posts':
    case '/users/sign_in':
    case '/users/sign_up':
        getLocation();
        break;
  }

  if (location_path.match(/posts\/[0-9][0-9]/)) { 
    var tideChart = $('#forecast-data').data('tidechart')
    var tideData = $('#forecast-data').data('tidedata')
    appendTideData(tideData, '#tideTable')
    var hours = tideChart.hours.map((time) => new Date(time).getHours())
    var daily = $('#forecast-data').data('daily')
    renderChart('line', 'tide', tideChart.seaLevels, hours, 'tideChart', ["rgb(0, 128, 0)"], tideOptions)
    renderChart('bar', 'mt. waves', daily.waveHeight, daily.days, 'waveChart', [], waveOptions)
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
