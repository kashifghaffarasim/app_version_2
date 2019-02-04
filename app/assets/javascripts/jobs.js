
function AddQuantity(id) {
    if (id) {
        var a = id.split('job_line_items_attributes_')
        var number = a[1].split('_quantity')
        var quantity = document.getElementById(id).value;
        var unit_id = "job_line_items_attributes_" + number[0] + "_unit_cost";
        var units = document.getElementById(unit_id).value;
        if (units && quantity) {
            var total_id = "job_line_items_attributes_" + number[0] + "_total";
            itemTotal(quantity, units, total_id);
        }
    }
}


function AddPrice(id) {

    if (id) {
        var a = id.split('job_line_items_attributes_')
        var number = a[1].split('_unit_cost')
        var units = document.getElementById(id).value;
        var quantity_id = "job_line_items_attributes_" + number[0] + "_quantity"
        var quantity = document.getElementById(quantity_id).value;
        if (units && quantity) {
            var total_id = "job_line_items_attributes_" + number[0] + "_total";
            itemTotal(quantity, units, total_id);
        }
    }
}


function itemTotal(quantity, price, number_id) {
    var total = quantity * price;
    document.getElementById(number_id).setAttribute('value', total);
}