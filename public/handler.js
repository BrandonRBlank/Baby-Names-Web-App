$(document).ready(() => {
    let count = 0;
    let years = [1900, 1910, 1920, 1930, 1940, 1950, 1960, 1970, 1980, 1990, 2000];
    let colors = ["blue", "red", "green", "purple"];
    let ctx = document.getElementById("myChart");
    let myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: years,
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        reverse: true,
                        max: 1000
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Popularity'
                    }
                }],
                xAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: 'Year'
                    }
                }]
            }
        }
    });
    $('#input').on("change", (evt) => {
        let text = $('#input').val();
        if(count === 4) {
            $('#note-box').text("Only 4 names are allowed to be displayed at a time.");
            return;
        }
        $.get("/baby", {text: text})
            .done((data) => {
                $('#input').val('');

                if(data['error']) {
                    $('#note-box').text(data['error']);
                    return;
                }
                if(!data['baby']) {
                    $('#note-box').text("No data available for " + data['result']);
                    return;
                }

                chart(data['baby'], data['result'], myChart, colors[count]);
                count++;
            })
            .fail((xhr) => {
                alert('Problem contacting server');
                console.log(xhr);
            });
    });
});

function chart(baby, name, chart, color) {
    chart.data.datasets.push({
        label: name,
        data: baby,
        fill: false,
        borderColor: color
    });
    chart.update();
}