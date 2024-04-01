import com.fox.Minigames.Gridris.BaseShape;
/**
 * ...
 * @author SecretFox
 */
class com.fox.Minigames.Gridris.glyph extends BaseShape
{
	// Glyph
	public var m_ItemId:Number = 9284361;
	public var Shape = 
	[
		[
			[ -1, 0], [ 0, 0], [ 0, -1], [ 1, -1]
		],
		[
			[ 0, -1], [ 0, 0], [ 1, 0], [ 1, 1]
		],
		[
			[ 1, 0], [ 0, 0], [ 0, 1], [ -1, 1]
		],
		[
			[ 0, 1], [ 0, 0], [ -1, 0], [ -1, -1]
		]
	]

	public function glyph(root) 
	{
		super(root);
		m_Name = "Glyph";
	}
}