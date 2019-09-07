# Popover
Popover list at any place on screen from any object in View.
Can be used in both Swift and Objective C.


Example - Swift

func show(view: UIView) {

    // Create a data source
    let spiceList = ["A", "B", "C", "D"]
    // Init a popover with a callback closure after selecting data
    let popover = CustomPopover(for: view, title: "Title") { (selectedValue) in
        guard let value = selectedValue else { return }
        print(value)
    }
    // Assign data to the dataList
    popover.dropdownList = spiceList
    present(popover, animated: true, completion: nil)
    
}
