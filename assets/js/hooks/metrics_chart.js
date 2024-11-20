import Chart from 'chart.js/auto';

export default {
  mounted() {
    const ctx = this.el.getContext('2d');

    this.chart = new Chart(ctx, {
      type: 'line',
      data: this.getChartData(),
      options: {
        responsive: true,
        maintainAspectRatio: false, // Ensure fixed size is maintained
        animation: false,
        plugins: {
          legend: {
            position: 'top',
          },
          tooltip: {
            mode: 'index',
            intersect: false
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            ticks: {
              callback: (value) => `${value}%`
            }
          }
        },
        interaction: {
          mode: 'nearest',
          axis: 'x',
          intersect: false
        }
      }
    });
  },

  updated() {
    this.chart.data = this.getChartData();
    this.chart.update('none');
  },

  destroyed() {
    if (this.chart) {
      this.chart.destroy();
    }
  },

  getChartData() {
    const metrics = JSON.parse(this.el.dataset.metrics);
    return {
      labels: metrics.map(m => m.date),
      datasets: [
        {
          label: 'Completion Rate',
          data: metrics.map(m => m.completion),
          borderColor: '#4C51BF',
          backgroundColor: '#4C51BF20',
          fill: true,
          tension: 0.4
        },
        {
          label: 'Tasks',
          data: metrics.map(m => m.tasks),
          borderColor: '#48BB78',
          backgroundColor: '#48BB7820',
          fill: true,
          tension: 0.4
        }
      ]
    };
  }
};
