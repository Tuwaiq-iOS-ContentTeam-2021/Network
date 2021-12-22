
import UIKit

class MyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
