

var selectedCategory;

function selectCategory() {
   
    
    selectedCategory = event.target.getAttribute("value")

    console.log(selectedCategory);
    $('tr').removeClass("bg__colour");
    $('#CategoryRow_' + selectedCategory).addClass("bg__colour");
 
}


function EditCategory() {

    if (selectedCategory == null || selectedCategory == undefined)
    {
        toastr.error("Please Select the row first");
    }
    else
    {
        $.ajax({
            url: "/InventoryAdmin/EditCategory?categoryId=" + selectedCategory,
            type: 'GET',
            success: function (data) {
                console.log(data);
                console.log(data.CategoryName);
                
                var obj = JSON.parse(data);
                console.log(obj);
                console.log(obj.CategoryName);
                $('#CategoryId').val(obj.CategoryId);
                $('#CategoryName').val(obj.CategoryName);
               /* $('#DateTimeMission').attr("max", data.maxDate);*/
                $('#CategoryDescription').text(obj.Description);
                $('#CategoryAddModal').modal('show');
              

            },
            error: function (error) {
                console.log(error);
            }

        })

    }

}