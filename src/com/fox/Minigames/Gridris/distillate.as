import com.fox.Minigames.Gridris.BaseShape;
/**
 * ...
 * @author SecretFox
 */
class com.fox.Minigames.Gridris.distillate extends BaseShape
{
	// blue weapon distillate
	public var m_ItemId:Number = 9287656;
	public var KickTable = [];
	public var Shape = 
	[
		[
			[ -1, -1], [ -1, 0], [ 0, 0], [ 0, -1]
		]
	]

	public function distillate(root) 
	{
		super(root);
		m_Name = "Distillate";
	}
}