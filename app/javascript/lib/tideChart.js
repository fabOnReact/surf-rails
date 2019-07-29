var yAxes = [{
    scaleLabel: { display: false },
    weight: 0,
    ticks: {
      beginAtZero: true,
      display: false,
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
    autoSkip:false,
  },
  color: 'red',
}]

export var tideOptions = {
  legend: { display: false },
  responsive: true,
  mantainAspectRatio: false,
  scales: {
    yAxes: yAxes,
    xAxes: xAxes,
  }
}
