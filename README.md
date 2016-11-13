# TYMagnificationTransition  
-------
通过shapeLayer实现的放大效果的控制器转场动画，能够设置放大图形，位置，大小，动画时间

##图形
-------
* 矩形
* 圆形
* 三角形
* 五角星（待更新）  

##位置
----
present与dismiss的位置，通过margin设置
##大小
----
通过diameter设置
##动画时间
----
通过duration设置
##用例
----  
	@implementation ViewController
	{
	    MagnificationAnimator * _magniAnima;
	}
	//重写初始化方法，如果你使用纯代码的方式，重写init
	- (instancetype)initWithCoder:(NSCoder *)coder
	{
	    self = [super initWithCoder:coder];
	    if (self)
	    {
	        self.modalPresentationStyle = UIModalPresentationCustom;
	        //配置参数
	        _magniAnima= [MagnificationAnimator
                      magnificationAnimatorWithShapeType:ShapeTypeTriangle diameter:20 topMargin:100 rightMargin:100 duration:0.25];
	        //强引用
	        self.transitioningDelegate = _magniAnima;
	    }
	    return self;
	}
    
    

