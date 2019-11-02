package main

import (
    "github.com/prometheus/client_golang/prometheus"
    "time"
    "os/exec"
    "fmt"
    "strconv"
    "strings"
)

//Define the metrics we wish to expose
var fooMetric = prometheus.NewGauge(prometheus.GaugeOpts{
	Name: "idw_m1", Help: "first value of the field"})

var barMetric = prometheus.NewGauge(prometheus.GaugeOpts{
	Name: "idw_m2", Help: "total number of rows"})

func init() {
	//Register metrics with prometheus
	prometheus.MustRegister(fooMetric)
	prometheus.MustRegister(barMetric)

    go func(){
        for {
            //Set fooMetric to 1
          //  fooMetric.Add(rand.Float64())
	    out, err := exec.Command("/bin/bash","execQuery.sh").Output()
	    if err != nil {
		    println(err)
	    }
	    println("Comand executed")
	    fmt.Println(out)
	    output := string(out[:])

	    fmt.Println(strings.TrimSpace(output))
	    fmt.Println("....",string(output[7]))

	    n, err := strconv.ParseFloat(string(strings.TrimSpace(output)),64)
	    if err != nil {
	    	fmt.Printf("--eeeror %s\n ",err)
	    }

		fmt.Printf("----==findl ===-%d",n)
		fooMetric.Set(n)

	    

            //Set barMetric to 0
            barMetric.Set(1)
            time.Sleep(2 * time.Second)
        }
    }()
}


