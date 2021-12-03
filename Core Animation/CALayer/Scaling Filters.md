# Scaling Filters

原文地址：[https://developer.apple.com/documentation/quartzcore/calayer/scaling_filters?changes=la_11_3](https://developer.apple.com/documentation/quartzcore/calayer/scaling_filters?changes=la_11_3)

These constants specify the scaling filters used by [magnificationFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410907-magnificationfilter?changes=la_11_3) and [minificationFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410898-minificationfilter?changes=la_11_3).

这些常量指定用于 [magnificationFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410907-magnificationfilter?changes=la_11_3) 和 [minificationFilter](https://developer.apple.com/documentation/quartzcore/calayer/1410898-minificationfilter?changes=la_11_3) 的缩放滤波器。

# Topics 主题

## Constants 常量

### static let [linear](https://developer.apple.com/documentation/quartzcore/calayercontentsfilter/1410850-linear?changes=la_11_3): CALayerContentsFilter

Linear interpolation filter.

线性插值滤波器。

### static let [nearest](https://developer.apple.com/documentation/quartzcore/calayercontentsfilter/1410831-nearest?changes=la_11_3): CALayerContentsFilter

Nearest neighbor interpolation filter.

最近邻插值滤波器。

### static let [trilinear](https://developer.apple.com/documentation/quartzcore/calayercontentsfilter/1410978-trilinear?changes=la_11_3): CALayerContentsFilter

Trilinear minification filter. Enables mipmap generation. Some renderers may ignore this, or impose additional restrictions, such as source images requiring power-of-two dimensions.

三重线性缩小滤波器。启用 mipmap 生成。一些渲染器可能会忽略它，或者添加额外的限制，例如原图像需要二维效果时。

> # 译者注
> 最近取样，双线性，三线性是计算机图形学中最常用的三种图片放缩算法。
> 
> 假设原图 40x40，拉伸目标 80x120，也就是水平 2 倍，垂直 3 倍。目标中的点例如 (5, 8)，除以倍数，对应着原图的 (2.5, 2.67)。
> 
> - **最近取样：**(2.5, 2.67) 实际取原图 (2, 3)，当然可以取 (3, 3)，这个区别不大，直接取出来作为新图的像素。
> - **双线性：**根据 (2.5, 2.67) 取出周围四个点 (2, 2)，(2, 3)，(3, 2)，(3, 3) 的像素，按照线性位置取各自的比例，加权：先算 x 或 y 方向，比如先算 0.5 倍的 p(2, 2) 加 0.5 倍的 p(3, 2)，得到 p1，0.5 倍的 p(2, 3) 加 0.5 倍的 p(3, 3) 得到 p2；然后 0.67 倍的 p2 加 0.33 倍的 p1，得到最终结果。
> - **三线性：**重点是三线性会产生 mipmap，就是会预生成一系列不同大小的图片，双线性的结果在不同大小图片间再次线性插值，得到最终结果。
> 
> 对于大图，最近过滤速度非常快，但效果不好。双线性和三线性效果差不多，但是三线性存储了一系列不同大小的图片，多次缩放取值时，可以根据目标大小直接从系列里取接近的图片，空间换时间。
>
>计算机里只有水平/垂直，但现实图片需要斜线，使用最近过滤可以直观地感受到斜线有锯齿感，因为只考虑单像素点，不考虑附近点的颜色。而这种特点在极少斜线的图中恰恰成为了优势：保留了像素之间的差异。线性过滤更像是保留形状。对于没有斜线的小图，使用最近过滤的优势很大，反而线性过滤考虑周围像素点导致了失真。
>
>总的来说，最近过滤的应用场景适合少有斜线的情况；线性过滤则相反。
>
>参考文章：[iOS CoreAnimation (八) 拉伸过滤，组透明，magnificationFilter，allowsGroupOpacity，opaque，光栅化 shouldRasterize](https://blog.csdn.net/m0_38076563/article/details/111679999)