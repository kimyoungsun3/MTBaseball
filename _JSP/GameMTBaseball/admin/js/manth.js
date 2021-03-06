

function setStyle(id,style,value){
    id.style[style] = value;
}
function opacity(el,opacity){
    setStyle(el,"filter:","alpha(opacity="+opacity+")");
    setStyle(el,"-moz-opacity",opacity/100);
    setStyle(el,"-khtml-opacity",opacity/100);
    setStyle(el,"opacity",opacity/100);
}
function calendar(url, today){
    var date = new Date(today);
    var day = date.getDate();
    var month = date.getMonth();
    var year = date.getYear();
    if(year<=200){
		year += 1900;
    }
    
    months = new Array('01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12');
    days_in_month = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
    days = new Array(
    	'00', 
    	'01', '02', '03', '04', '05', '06', '07', '08', '09', '10',
    	'11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
    	'21', '22', '23', '24', '25', '26', '27', '28', '29', '30',
    	'31', '32', '33'
    );
    if(year%4 == 0 && year!=1900){
		days_in_month[1]=29;
    }
    
    total = days_in_month[month];
    var date_today = year+'년'+months[month]+'월 '+day+'일';
    var date_today2;
    beg_j = date;
    beg_j.setDate(1);
    if(beg_j.getDate()==2){
		beg_j=setDate(0);
    }
    
    beg_j = beg_j.getDay();
    document.write('<table class="cal_calendar" onload="opacity(document.getElementById(\'cal_body\'),20);"><tbody id="cal_body"><tr><th colspan="7">'+date_today+'</th></tr>');
    document.write('<tr class="cal_d_weeks"><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr><tr>');
    week = 0;
    
    for(i=1;i<=beg_j;i++){
		document.write('<td class="cal_days_bef_aft">'+(days_in_month[month-1]-beg_j+i)+'</td>');
		week++;
    }
    
    for(i=1;i<=total;i++){
		if(week==0){
			document.write('<tr>');
		}
		date_today2 = year + months[month] + days[i];
		if(day==i){
			document.write('<td class="cal_today"><a href='+url+'?dateid='+date_today2+'>'+days[i]+'</a></td>');
		}else{
			document.write('<td><a href='+url+'?dateid='+date_today2+'>'+days[i]+'</a></td>');
		}
		week++;
		if(week==7){
			document.write('</tr>');
			week=0;
		}
    }
    for(i=1;week!=0;i++){
		document.write('<td class="cal_days_bef_aft">'+i+'</td>');
		week++;
		if(week==7){
			document.write('</tr>');
			week=0;
		}
    }
    document.write('</tbody></table>');
    opacity(document.getElementById('cal_body'),70);
    return true;
}

