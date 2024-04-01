import com.fox.Minigames.Gridris.BaseShape;
/**
 * ...
 * @author SecretFox
 */
class com.fox.Minigames.Gridris.cache extends BaseShape
{
	// Cache
	public var m_ItemId:Number = 9383974;
	public var Shape = 
	[
		[
			[ -1, -1], [ 0, -1], [ 0, 0], [ 1, 0]
		],
		[
			[ 1, -1], [ 1, 0], [ 0, 0], [ 0, 1]
		],
		[
			[ 1, 1], [ 0, 1], [ 0, 0], [ -1, 0]
		],
		[
			[ -1, 1], [ -1, 0], [ 0, 0], [ 0, -1]
		]
	]
	
	public function cache(root) 
	{
		super(root);
		m_Name = "Cache";
	}
}