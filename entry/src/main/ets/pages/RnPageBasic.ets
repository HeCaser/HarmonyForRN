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
  @State inputText: string = 'app_name'

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Text(`1本页展示 RN 基础: 加载一个 RN 页面(默认 app_name), 支持 Metro 和本地文件加载`).height(50)
      TextInput({
        placeholder: '输入要加载的 RN 页面',
      }).onChange((value) => {
        this.inputText = value
      }).margin({ top: 16 }).placeholderFont({ size: 12 })

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

