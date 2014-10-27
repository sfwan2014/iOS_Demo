var context = document.getElementById("canvas").getContext("2d");

var polarData =%@

//[
//    {
//        value : 89,
//        color: "#D97041"
//    },
//    {
//        value : 90,
//        color: "#C7604C"
//    },
//    {
//        value : 90,
//        color: "#21323D"
//                 },
//                 {
//                 value : 78,
//                 color: "#9D9B7F"
//                 },
//                 {
//                 value : 77,
//                 color: "#7D4F6D"
//                 },
//                 {
//                 value : 67,
//                 color: "#584A5E"
//                 },
//                 {
//                 value : 70,
//                 color: "#584A5E"
//                 },
//                 {
//                 value : 78,
//                 color: "#9D9B7F"
//                 },
//                 {
//                 value : 77,
//                 color: "#7D4F6D"
//                 },
//                 {
//                 value : 67,
//                 color: "#584A5E"
//                 },
//                 {
//                 value : 70,
//                 color: "#584A5E"
//                 }
//]

var polarArea = new Chart(context).PolarArea(polarData);