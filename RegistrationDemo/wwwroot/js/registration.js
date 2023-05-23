$('#BirthdayDate').on('change', function () {
        var date = $('#BirthdayDate').val();
  
    var today = new Date();
    var birthDate = new Date(date);
    var age = today.getFullYear() - birthDate.getFullYear();
    var month = today.getMonth() - birthDate.getMonth();
    /*console.log(today.getDay());
    console.log(birthDate.getDay());
    console.log(birthDate);
    var day = today.getDay() - birthDate.getDay();*/

    if (month < 0 || (month === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
   /* if (month == 0 && day == 0) {
        $('#HappyBirthdayText').text("Happy Birthday to you! many many happy returns of the day!");
    }*/

    $('#BirthdayYearText').text("Your Age is " + age);

    console.log(currentDate);
    
    console.log(date);

})