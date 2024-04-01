import com.fox.Minigames.Gridris.BaseShape;
/**
* ...
* @author SecretFox
*/
class com.fox.Minigames.Gridris.flappy extends BaseShape
{
	// Flappy
	public var m_ItemId:Number = 7252752;
	public var Shape = 
	[
		[
			[ -1, -1], [ -1, 0], [ 0, 0], [ 1, 0]
		],
		[
			[ 1, -1], [ 0, -1], [ 0, 0], [ 0, 1]
		],
		[
			[ 1, 1], [ 1, 0], [ 0, 0], [ -1, 0]
		],
		[
			[ -1, 1], [ 0, 1], [ 0, 0], [ 0, -1]
		]
	]

	public function flappy(root) 
	{
		super(root);
		m_Name = "Flappy";
	}
}