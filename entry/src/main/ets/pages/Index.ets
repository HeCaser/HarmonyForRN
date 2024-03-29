import { ComponentBuilderContext } from 'rnoh';
import { RNApp, RNAbility, AnyJSBundleProvider, MetroJSBundleProvider, ResourceJSBundleProvider } from 'rnoh'
import { SampleView, SAMPLE_VIEW_TYPE, PropsDisplayer } from "rnoh-sample-package"
import { createRNPackages } from '../RNPackagesFactory'

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

  onBackPress(): boolean | undefined {
    return this.rnAbility?.onBackPress();
  }

  build() {
    Column() {
      Button("点击加载 RN").onClick(()=>{
        this.shouldShow = true
      })
      if (this.rnAbility && this.shouldShow) {
        Text("RN页面")
        RNApp({
          rnInstanceConfig: { createRNPackages },
          initialProps:{"param":'init data from harmony'} as  Record<string, string>,
          appKey: "init_param",
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
    .padding({top:50})
  }
}

