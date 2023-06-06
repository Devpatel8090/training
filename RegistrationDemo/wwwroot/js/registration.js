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

    /*console.log(today.getMonth() + 1);
    console.log(birthDate.getMonth() + 1);*/

    if(today.getMonth() == birthDate.getMonth() && today.getDate() == birthDate.getDate()) {
        $('#HappyBirthdayText').text(" Happy Birthday to you! Many Many Happy Returns of the day!");
    }
    else
    {
        $('#HappyBirthdayText').text("");
    }
   /* if (month == 0 && day == 0) {
        $('#HappyBirthdayText').text("Happy Birthday to you! many many happy returns of the day!");
    }*/

    $('#BirthdayYearText').text("Your Age is " + age);

    
    
    console.log(date);

})

function GetStatesByCountryId() {
    var countryId = $('#CountryId').val();
    /*var countryID2 = $('#CountryId').find(":selected").val();*/
    $.ajax({
        url: "/Registration/GetStateDetailsByCountry?countryId=" + countryId,
        type: "GET",
        success: function (data) {
            console.log(data);
            var items = `<option value="-1">Please Select the State</option>`;
            $(data).each(function (i, item) {
                items += `<option value=${item.stateId}>` + item.stateName + `</option>`
                console.log(item);
            });
            $('#StateId').html(items);
            $('#CityId').html("");
        },
        error: function (error) {
            console.log(error);
        }
    })

}
function GetCitiesByStateId() {
    var cityId = $('#StateId').val();
    /*var cityId2 = $('#CountryId').find(":selected").val();*/
    $.ajax({
        url: "/Registration/GetCityDetailsByState?stateId=" + cityId,
        type: "GET",
        success: function (data) {
            console.log(data);
            var items = `<option value="-1">Please Select the City</option>`;
            $(data).each(function (i, item) {
                items += `<option value=${item.cityId}>` + item.cityName + `</option>`
                console.log(item);
            });
            $('#CityId').html(items);
        },
        error: function (error) {
            console.log(error);
        }
    })

}