
function updateItemStatus(){
	var cbId = this.id.replace("cb_", "");
	var itemText = document.getElementById("item_"+cbId);
	
	if (this.checked){
		itemText.style.textDecoration = "line-through";
		itemText.style.color = "#c00";
		itemText.style.fontweight = "800";
	}
	else{
		itemText.style.textDecoration = "none";
		itemText.style.color = "#000";
		itemText.style.fontweight = "#c00";
	}
}

function renameItem(){
	var newText = prompt("Rename: ");
	if(!newText || newText == "" ||newText == " "){
		return false;
	}
	else{
		this.innerText = newText;
	}
}

function removeItem(){
	//this == span
	var spanId = this.id.replace("item_", "");

}

function addNewItem(list, itemText){
	
	var date = new Date();
	var id = ""+date.getHours()+date.getMinutes() + date.getSeconds();
	
	var listItem = document.createElement("li");
	listItem.id = "li_"+id;
	listItem.ondblclick = removeItem;
	
	var checkBox = document.createElement("input");
	checkBox.type = "checkbox";
	checkBox.id = "cb_" + id;
	checkBox.onclick = updateItemStatus;
	
	var span = document.createElement("span");
	span.id = "item_"+id;
	span.innerText = itemText;
	span.onclick = renameItem;
	
	
	listItem.appendChild(checkBox);
	listItem.appendChild(span);
	list.appendChild(listItem);
}


var inItemText = document.getElementById("inItemText");
inItemText.focus();
inItemText.onkeyup = function(event){
	
	if (event.which == 13){
		var itemText = inItemText.value;
	
	
		/*if (itemText = "" || itemText == " "){
			return false;
		}*/
	

	addNewItem(document.getElementById("toDoList"), itemText);
	inItemText.focus();
	inItemText.select();
	}
};

