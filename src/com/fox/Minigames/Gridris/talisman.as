import com.fox.Minigames.Gridris.BaseShape;
/**
 * ...
 * @author SecretFox
 */
class com.fox.Minigames.Gridris.talisman extends BaseShape
{
	// Talisman
	public var m_ItemId:Number = 9289652;
	public var Shape = 
	[
		[
			[ 1, -1], [ 1, 0], [ 0, 0], [ -1, 0]
		],
		[
			[ 1, 1], [ 0, 1], [ 0, 0], [ 0, -1]
		],
		[
			[ -1, 1], [ -1, 0], [ 0, 0], [ 1, 0]
		],
		[
			[ -1, -1], [ 0, -1], [ 0, 0], [ 0, 1]
		]
	]
	
	public function talisman(root) 
	{
		super(root);
		m_Name = "Talisman";
	}
}