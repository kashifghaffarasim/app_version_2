
function AddQuantity(id) {
    if (id) {
        var a = id.split('job_line_items_attributes_')
        var number = a[1].split('_quantity')
        var quantity = document.getElementById(id).value;
        var unit_id = "job_line_items_attributes_" + number[0] + "_unit_cost";
        var units = document.getElementById(unit_id).value;
        var total_id = "job_line_items_attributes_" + number[0] + "_total";
        if (units && quantity) {
            itemTotal(quantity, units, total_id);
        } else {
            itemTotal(0, 0, total_id);
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
        var total_id = "job_line_items_attributes_" + number[0] + "_total";
        if (units && quantity) {
            itemTotal(quantity, units, total_id);
        } else {
            itemTotal(0, 0, total_id);
        }
    }
}


function itemTotal(quantity, price, number_id) {
    var total = quantity * price;
    if (total && total > 0) {
        document.getElementById(number_id).setAttribute('value', total);
    } else {
        document.getElementById(number_id).setAttribute('value', 0);
    }
    sub_total();
}


function getTax(id) {
    var tax = document.getElementById(id).value;
    if (tax) {
        document.getElementById('tax').setAttribute('value', tax);
    }
    total_estimates();
}

function getDiscount(id) {
    var discount = document.getElementById(id).value;
    if (discount) {
        document.getElementById('discount').setAttribute('value', discount);
    }
    total_estimates();
}

function sub_total() {
    var i = 0;
    var grand_total = 0;
    while (1) {
        var id = "job_line_items_attributes_" + i + "_total";
        var element = document.getElementById(id);
        if (element) {
            var value = document.getElementById(id).value;
            grand_total = +grand_total + +value;
            i = i + 1;
        } else {
            break
        }
    }
    document.getElementById('job_sub_total').setAttribute('value', grand_total);
    total_estimates();
}


function total_estimates(){
    var tax = document.getElementById('tax').value;
    var sub_total = document.getElementById('job_sub_total').value;
    var total_tax = 0;
    
    if(tax > 0 && sub_total > 0){
       total_tax = sub_total * (tax/100)
    }
    
    var discount = document.getElementById('discount').value;
    var total =  +sub_total + +total_tax;
    var grand_total = total - discount;
    document.getElementById('job_grand_total').setAttribute('value', grand_total);
    
}