# xingpan
iOS星盘，浅谈如何实现
博主原创，不喜勿喷，
详情查看，
https://www.jianshu.com/p/cb4118b4b8c3

IOS用CGContextRef画各种图形(文字、圆、直线、弧线、矩形、扇形、椭圆、三角形、圆角矩形、贝塞尔曲线、图片)


如图：可以参考的app：爱星盘，星座大师

https://www.d1xz.net/xp/

http://product.astro.sina.com.cn/swe/result?r=0&sex=male&geo=China&summer=0&city=CH010100&longitude1=116&longitude2=28&longitude3=E&latitude1=39&latitude2=55&latitude3=N&zone=8&year=2013&month=8&day=18&hour=0&minute=0&name=里到

www.ixingpan.com

主要功能，下方有个时间间隔功能，每次点击一次，就会各个圆转动一次。

从而形成转动的效果，千万不要为了这个假象迷惑住了，实际上是每次点击就请求数据，刷新view的操作，相当于重新绘制星盘。



项目地址：https://github.com/mrzhao12/xingpan

博主原创，有人推荐用圆形统计图，和贝瑟尔，后来发现都不合适。没有

 // 画布

        CGContextRef context = UIGraphicsGetCurrentContext();



          //画大圆并填充颜

        CGContextSetLineWidth(context, 1);//线的宽度

        CGContextSetRGBStrokeColor(context,0.725,0.552,0,1);//画笔线的颜色

//        UIColor*tianChongColor = OIRGBA(246, 251, 186, 1);

    UIColor*tianChongColor = [UIColorcolorWithRed:246green:251blue:186alpha:1];

           CGContextSetFillColorWithColor(context, tianChongColor.CGColor);//填充颜色

        CGContextAddArc(context, myYuanXinX,myYuanXinY, [self.xpModel.params.maxRadiusfloatValue],0,2*M_PI,1);//添加一个圆

     CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充



快

感谢：

IOS用CGContextRef画各种图形(文字、圆、直线、弧线、矩形、扇形、椭圆、三角形、圆角矩形、贝塞尔曲线、图片)
