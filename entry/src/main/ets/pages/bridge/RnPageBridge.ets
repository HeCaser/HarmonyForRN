import { RNApp, RNAbility, AnyJSBundleProvider, MetroJSBundleProvider, ResourceJSBundleProvider } from 'rnoh'
import { createRNPackages } from '../../RNPackagesFactory'



@Entry
@Component
struct Index {
  @StorageLink('RNAbility') rnAbility: RNAbility | undefined = undefined
  @State shouldShow: boolean = false
  @State inputText: string = 'bridge'

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Text(`本页展示 RN 基础: Bridge`).height(50)

      Button("点击加载 RN").margin({ top: 16 })
        .width('100%')
        .height(50)
        .onClick(() => {
          this.shouldShow = true
        })

      if (this.rnAbility && this.shouldShow) {
        RNApp({
          rnInstanceConfig: { createRNPackages },
          initialProps: { "param": 'init data from harmony' } as Record<string, string>,
          appKey: this.inputText,
          jsBundleProvider: new AnyJSBundleProvider([
            new MetroJSBundleProvider(), // 先尝试 Metro 加载, 加载失败会继续进行本地加载
            new ResourceJSBundleProvider(this.rnAbility.context.resourceManager, 'bundle.harmony.js')]),
        }).height('100%').margin({ top: 10 })
      } else {
        Text("原生页面").width('100%').height('100%').textAlign(TextAlign.Center)
      }
    }
    .height('100%')
    .width('100%')
    .padding({ top: 50, left: 16, right: 16 })

  }
}

