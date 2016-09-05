/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function () {
    $.ajax({
        url: "ws/rest/messages",
        async: true
    })
            .done(function (data) {
                var news_ul = document.getElementById("news-feed-ul");
                news_ul.innerHTML = '';
                for(var i=0; i < data.length; i++) {
                    if(data[i].type > 1) {
                        var row = "<li class='list-group-item'>" + data[i].content + "</li>";
                        news_ul.innerHTML += row;
                    }
                }
            });
});