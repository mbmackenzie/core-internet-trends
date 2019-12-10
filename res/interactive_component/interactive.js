var width = 800,
    height = 500,
    margin = {
        top: 20,
        right: 20,
        bottom: 20,
        left: 40
    },
    innerWidth = width - margin.left - margin.right,
    innerHeight = height - margin.top - margin.bottom;

var svg = d3.select("#chart")
    .append("svg")
    .attr("width", width)
    .attr("height", height);

svg.append("g")
    .attr("id", "map")
    .attr('transform', `translate(${margin.left}, ${margin.top})`);

var year = "2018",
    social_media = "youtube",
    social_media_name = "YouTube";

var projection = d3.geoAlbersUsa()
    .translate([1.05 * (innerWidth / 2), innerHeight / 2]) // translate to center of screen
    .scale([930]); // scale things down so see entire US

var path = d3.geoPath()
    .projection(projection); // tell path generator to use albersUsa projection

var map_dataset = null;
var social_dataset = data;
var current_state = null;

var minVal = 0;
var maxVal = 0;

var axis_off = 75,
    grad_off = 15;

var lowColor = '#fff';
var highColorConf = {
    "youtube": "#bb0000",
    "facebook": "#3B5998",
    "instagram": "#125688",
    "pintrest": "#cb2027",
    "linkedin": "#007bb5",
    "twitter": "#55ACEE ",
    "snapchat": "#fffc00",
    "whatsapp": "#25d366"
};

function drawLegend() {

    var legend = svg.append("defs")
        .append("svg:linearGradient")
        .attr("id", "gradient")
        .attr("x1", "100%")
        .attr("y1", "0%")
        .attr("x2", "100%")
        .attr("y2", "100%")
        .attr("spreadMethod", "pad");

    legend.append("stop")
        .attr("offset", "0%")
        .attr("stop-color", highColorConf[social_media])
        .attr("stop-opacity", 1);

    legend.append("stop")
        .attr("offset", "100%")
        .attr("stop-color", lowColor)
        .attr("stop-opacity", 1);

    var y = d3.scaleLinear()
        .range([innerHeight - axis_off, axis_off])
        .domain([0, 1]);

    var formatPercent = d3.format(".0%");
    var yAxis = d3.axisRight(y)
        .ticks(10)
        .tickFormat(formatPercent);

    svg.select("#map")
        .append("rect")
        .attr("id", "lgnd")
        .attr("rx", 6)
        .attr("ry", 6)
        .attr("width", 44)
        .attr("height", innerHeight - (2 * axis_off) + (2 * grad_off))
        .style("fill", "url(#gradient)")
        .attr("transform", `translate(-4, ${axis_off - grad_off})`);

    svg.select("#map")
        .call(yAxis);

    svg.append("text")
        .style("text-anchor", "middle")
        .attr("transform", "rotate(-90)")
        .attr("y", 10)
        .attr("x", 0 - (height / 2))
        .attr("dy", "1em")
        .style('font-size', "16px")
        .text("Percent of Users");

}

function updateLegend() {

    var legend = svg.select("#gradient");

    if (legend.empty() == true) {
        return;
    }

    legend.selectAll("stop").remove();

    legend.append("stop")
        .attr("offset", "0%")
        .attr("stop-color", highColorConf[social_media])
        .attr("stop-opacity", 1);

    legend.append("stop")
        .attr("offset", "100%")
        .attr("stop-color", lowColor)
        .attr("stop-opacity", 1);

    svg.select("rect#lgnd")
        .transition()
        .duration(1500)
        .style("fill", "url(#gradient)");
}

function populateStat() {

    var select_dataset = social_dataset.filter(sm => sm.year == year && sm.app == social_media);
    for (var i = 0; i < map_dataset.length; i++) {
        var state_id = Number(map_dataset[i].id);

        var select_data = select_dataset.find(sm => sm.state_id == state_id);
        map_dataset[i].select_data = select_data;
    }

    var div = d3.select("div#tooltip");
    var ramp = d3.scaleLinear().domain([0, 1]).range([lowColor, highColorConf[social_media]]);

    svg.select("g#map")
        .selectAll("path")
        .filter(d => d)
        .data(map_dataset, d => d.id)
        .on("mouseover", function (d) {
            current_state = this;

            if (d.select_data) {
                var html = "State: " + d.properties.name + "<br/>" +
                    "Social Media: " + social_media_name + "<br/>" +
                    "Year: " + year + "<br/>" +
                    "User Base: <strong>" + Math.round(Number(Number(d.select_data.percent_use) * 100)) + "%</strong>" + "<br/>" +
                    "Total Respondents: <strong>" + d.select_data.total_respondents + "</strong>";

                div.transition()
                    .duration(200)
                    .style("opacity", .9);

                var padX = d3.event.pageX;
                var padY = d3.event.pageY + 50;

                if (d3.selectAll(".book").classed("with-summary") == true) {
                    try {
                        var sum_div = d3.select(".book .book-summary")
                        var pxl = parseInt(sum_div.style("width"))
                        padX = padX - pxl;

                    } catch (error) {}
                }

                div.html(html)
                    .style("left", padX + "px")
                    .style("top", padY + "px");
            }

        })

        // div.html(html)
        //     .style("left", d3.event.pageX + "px")
        //     .style("top", d3.event.pageY + "px");


        .on("mouseout", function (d) {
            current_state = null;
            div.transition()
                .duration(500)
                .style("opacity", 0);
        })
        .transition().duration(1500)
        .style("fill", function (d) {
            //console.log(d.id);
            if (d.select_data) {
                return ramp(d.select_data.percent_use);
            } else {
                return "rgb(194, 194, 194)";
            }
        })

    updateLegend();
}

//load data from files
var us_state_json = "https://raw.githubusercontent.com/mbmackenzie/edav-f19-final/master/data/interactive/us-states.json";
// var social_json = "https://raw.githubusercontent.com/mr3862/EDAVprojectMR/master/docs/data/state_social_media.json"
d3.json(us_state_json).then(function (json) {
    //console.log(json);

    svg.select("g#map")
        .selectAll("path")
        .data(json.features, d => d.id)
        .enter()
        .append("path")
        .attr("d", path)
        .style("stroke", "#e0e0e0")
        .style("stroke-width", "1")
        .style("fill", "#000");

    // d3.json(social_json).then(function (social) {
    //         social_dataset = social.data;
    //         map_dataset = json.features;
    //         populateStat();
    //         drawLegend();
    //     })
    //     .catch(function (err) {
    //         console.log(err);
    //     });

    map_dataset = json.features;
    populateStat();
    drawLegend();
});


socialMediaClickEvent = function () {

    d3.selectAll(".fa").classed("active", false);
    d3.select(this).classed("active", true);

    social_media = this.attributes.media.value;
    social_media_name = this.attributes.title.value;
    //console.log(social_media);

    d3.select("#spnSocialMedia").html(this.attributes.title.value);
    populateStat();
    event.preventDefault();
    return false;
}

yearClickEvent = function () {

    d3.selectAll(".lblyear").classed("active", false);
    d3.select(this).classed("active", true);

    year = this.attributes.year.value;
    d3.select("#spnYear").html(year);
    populateStat();
}

d3.selectAll(".lblyear").on("click", yearClickEvent);
d3.selectAll(".fa").on("click", socialMediaClickEvent);

d3.select("body")
    .on("keydown", function () {
        var keyCode = d3.event.keyCode;
        var selector;
        switch (keyCode) {
            case 81:
                selector = ".lblyear:not(.active)";
                break;
            case 49:
                selector = ".fa-youtube";
                break;
            case 50:
                selector = ".ict.fa-facebook";
                break;
            case 51:
                selector = ".fa-instagram";
                break;
            case 52:
                selector = ".fa-pinterest";
                break;
            case 53:
                selector = ".fa-linkedin";
                break;
            case 54:
                selector = ".ict.fa-twitter";
                break;
            case 55:
                selector = ".fa-snapchat-ghost";
                break;
            case 56:
                selector = ".fa-whatsapp";
                break;
            default:
                return;
        }

        d3.select(selector).node().click();
        if (current_state) {
            current_state.dispatchEvent(new Event('mouseover'));
        }
    });