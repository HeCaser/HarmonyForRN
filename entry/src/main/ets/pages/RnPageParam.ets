import { RNApp, RNAbility, AnyJSBundleProvider, MetroJSBundleProvider, ResourceJSBundleProvider } from 'rnoh'
import { createRNPackages } from '../RNPackagesFactory'


@Entry
@Component
struct Index {
  @StorageLink('RNAbility') rnAbility: RNAbility | undefined = undefined
  @State shouldShow: boolean = false


  aboutToAppear(): void {
    setTimeout(()=>{
      this.shouldShow = true
    },1000)
  }

  build() {
    Column() {
      Text("加载一个 RN 页面(init_param), 演示初始化参数")
      if (this.rnAbility && this.shouldShow) {
        RNApp({
          rnInstanceConfig: { createRNPackages },
          initialProps:{"param":'init data from harmony'} as  Record<string, string>,
          appKey: "init_param",
          jsBundleProvider: new AnyJSBundleProvider([
            new MetroJSBundleProvider(), // 先尝试 Metro 加载, 加载失败会继续进行本地加载
            new ResourceJSBundleProvider(this.rnAbility.context.resourceManager, 'bundle.harmony.js')]),
        })
      } else {
        Text("原生页面-RnPage")
      }

    }
    .height('100%')
    .width('100%')
    .padding({top:50})
  }
}

