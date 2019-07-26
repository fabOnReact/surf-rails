import Chart from 'chart.js';

export function renderTideChart(tide, times) {
  var ctx = document.getElementById('tideChart');
  var myChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: times,
        datasets: [{
          data: tide,
          backgroundColor: ["rgb(0, 128, 0)"],
          borderColor: [],
          borderWidth: 1,
          pointRadius: 0,
        }]
    },
    options: {
      legend: { display: false },
      scales: {
        yAxes: [{
            scaleLabel: { display: false },
            ticks: {
              beginAtZero: false,
              display: false,
            },
            gridLines: { 
                display: true,
                color: 'rgb(204, 0, 0)',
                lineWidth: 0,
            },
            tickMarkLength: 1,
        }],
        xAxes: [{
          gridLines: {
            display: true,
            zeroLineWidth: 10,
            zeroLineColor: '#ffcc33',
          },
          ticks: {
            display: true,
          },
          tickMarkLength: 10,
          color: 'red',
        }],
      }
    }
  });
}
