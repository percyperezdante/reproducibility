package main

import (
    "github.com/prometheus/client_golang/prometheus"
    "time"
    //"fmt"
    "log"
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
   // "strconv"
   // "strings"
)

var idwm1Metric = prometheus.NewGauge(
	prometheus.GaugeOpts{
		Name: "idw_m1", Help: "Number of rows of a table temp1"})

var idwm2Metric = prometheus.NewGauge(
	prometheus.GaugeOpts{
		Name: "idw_m2", Help: "total sum of field id in the table temp1"})

type Tag struct {
    ID   int    `json:"id"`
    Name string `json:"name"`
}

func init() {

    prometheus.MustRegister(idwm1Metric)
    prometheus.MustRegister(idwm2Metric)

    db, err := sql.Open("mysql", "percy:@tcp(127.0.0.1:3306)/test")

    if err != nil {
        panic(err.Error())
    }

    go func(){
        for {
    	    defer db.Close()

	    // Expose number of rows of table temp1
	    results, err := db.Query("SELECT count(*) FROM temp1")
	    if err != nil {
		panic(err.Error()) 
	    }
	    for results.Next() {
		var tag Tag
		err = results.Scan(&tag.ID)
		if err != nil {
		    panic(err.Error()) 
		}
		log.Printf("...%d \n ",tag.ID)
		idwm1Metric.Set(float64(tag.ID))
	    }

	    // Expose total sum of field id from temp1
	    sumId, errSum := db.Query("SELECT sum(id) from temp1")
	    if errSum != nil {
		    panic(errSum.Error())
	    }
	    for sumId.Next(){
		var tagSum Tag
		errSum = sumId.Scan(&tagSum.ID)
		if errSum != nil {
			panic(err.Error())
		}
		log.Printf("--- %d \n",tagSum.ID)
            	idwm2Metric.Set(float64(tagSum.ID))
	    }
            time.Sleep(2 * time.Second)
        }
    }()
}


