import { ComponentBuilderContext } from 'rnoh';
import { RNApp, RNAbility, AnyJSBundleProvider, MetroJSBundleProvider, ResourceJSBundleProvider } from 'rnoh'
import { SampleView, SAMPLE_VIEW_TYPE, PropsDisplayer } from "rnoh-sample-package"
import { createRNPackages } from '../RNPackagesFactory'
import router from '@ohos.router';

@Builder
function CustomComponentBuilder(ctx: ComponentBuilderContext) {
  if (ctx.componentName === SAMPLE_VIEW_TYPE) {
    SampleView({
      ctx: ctx.rnComponentContext,
      tag: ctx.tag,
      buildCustomComponent: CustomComponentBuilder
    })
  } else if (ctx.componentName === PropsDisplayer.NAME) {
    PropsDisplayer({
      ctx: ctx.rnComponentContext,
      tag: ctx.tag
    })
  }

}

@Entry
@Component
struct Index {
  @StorageLink('RNAbility') rnAbility: RNAbility | undefined = undefined
  @State shouldShow: boolean = false

  aboutToAppear(): void {
    setTimeout(() => {
      this.shouldShow = true
    }, 1000)
  }

  build() {
    Column() {
      Text("本页展示 RN 基础: 加载一个 RN 页面(app_name), 支持 Metro 和本地文件加载")
      if (this.rnAbility && this.shouldShow) {
        RNApp({
          rnInstanceConfig: { createRNPackages },
          initialProps: { "param": 'init data from harmony' } as Record<string, string>,
          appKey: "app_name",
          jsBundleProvider: new AnyJSBundleProvider([
            new MetroJSBundleProvider(), // 先尝试 Metro 加载, 加载失败会继续进行本地加载
            new ResourceJSBundleProvider(this.rnAbility.context.resourceManager, 'bundle.harmony.js')]),
        })
      } else {
        Text("原生页面")
      }

    }
    .height('100%')
    .width('100%')
    .padding({ top: 50 })
  }
}

