"use strict";


$(function(){
  updateTruck(0)
});

function updateTruck(indx){
  var truck = truckLoc[indx];
  $("#truckName").text(truck.Truck);
  $("#truckLocation").text(truck.Location);
  $("#truckDestination").text(truck.Destn);
  var next = (indx+1)==truckLoc.length?0:(indx+1);
  setTimeout(function(){updateTruck(next)},2500);
}

function getData(lasttime){
  // this is where the ajax call goes to the server
  // but for now we'll make shit up as usual
  var dy = (new Date(lasttime)).getDate();
  switch(dy){
    case 4:
      return day3;
    case 5:
      return day2;
    case 6:
      return day1;
  }
}
function draw(lasttime){
  $("#cycletime .datarow").remove();
  var tb = $("#cycletime");
  var daydata =getData(lasttime);
  daydata.forEach(function(dt){
    var tm = parseMSSQLDate(dt.EventDateTime);
    var diff = Math.floor((lasttime - tm) / (1000*60*60*24))
    if(diff<1){
      var mkp = "<tr class='datarow'>";
      mkp += "<td style='color:white;'>"+dt.Truck+"</td>";
      mkp += "<td style='color:white;'>"+dt.Location+"</td>";
      mkp += "<td style='color:white;'>"+dt.Destn+"</td>";
      var shtdt = dt.EventDateTime.substr(0,dt.EventDateTime.length -5);
      mkp += "<td style='color:white;'>"+shtdt+"</td>";
      mkp += "</tr>";
      tb.append(mkp)
    }
  });
}

var months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
function parseMSSQLDate(msDate){
  var sp = msDate.split(/[- :]/);
  sp[1] = months.indexOf(sp[1]);
  var nd = new Date(sp[0],sp[1],sp[2],sp[3],sp[4],sp[5]);
  return nd
}
