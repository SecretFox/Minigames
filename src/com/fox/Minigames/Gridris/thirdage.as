import com.fox.Minigames.Gridris.BaseShape;
/**
 * ...
 * @author SecretFox
 */
class com.fox.Minigames.Gridris.thirdage extends BaseShape
{
	// Fragment
	public var m_ItemId:Number = 9290325;
	public var Shape = 
	[
		[
			[ -1, 0], [ 0, 0], [ 1, 0], [ 0, -1]
		],
		[
			[ 0, -1], [ 0, 0], [ 0, 1], [ 1, 0]
		],
		[
			[ 1, 0], [ 0, 0], [ -1, 0], [ 0, 1]
		],
		[
			[ 0, 1], [ 0, 0], [ 0, -1], [ -1, 0]
		]
	]
	
	public function thirdage(root) 
	{
		super(root);
		m_Name = "Third age";
	}
}