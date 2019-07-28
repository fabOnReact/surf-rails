import Chart from 'chart.js';

export function renderChart(data, times, ctx, options) {
  new Chart(ctx, {
      type: 'bar',
      data: {
        labels: times,
        datasets: [{
          data: data,
          backgroundColor: [],
          borderColor: [],
          borderWidth: 1,
          pointRadius: 0,
        }]
    },
    options: options,
  });
}

var yAxes = [{
  scaleLabel: { display: true },
  weight: 0,
  ticks: {
    beginAtZero: true,
    display: true,
  },
  gridLines: { 
      display: true,
      color: 'rgb(204, 0, 0)',
      lineWidth: 0,
  },
  tickMarkLength: 0,
}]

var xAxes = [{
  display: true,
  weight: 0,
  gridLines: {
    display: true,
    zeroLineWidth: 0,
    zeroLineColor: '#ffcc33',
    tickMarkLength: 10,
  },
  ticks: {
    display: true,
    fontColor: 'black',
    fontFamily: 'Arial',
    fontStyle: 'normal',
    fontSize: 10,
    lineHeight: 1,
    maxRotation: 0,
    minRotation: 0,
  },
  color: 'red',
}]

export var options = {
  legend: { display: false },
  responsive: true,
  mantainAspectRatio: false,
  scales: {
    yAxes: yAxes,
    xAxes: xAxes,
  }
}
