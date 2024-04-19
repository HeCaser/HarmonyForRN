import { ComponentBuilderContext } from 'rnoh';
import { RNApp, RNAbility, AnyJSBundleProvider, MetroJSBundleProvider, ResourceJSBundleProvider } from 'rnoh'
import { SampleView, SAMPLE_VIEW_TYPE, PropsDisplayer } from "rnoh-sample-package"
import { createRNPackages } from '../RNPackagesFactory'
import router from '@ohos.router';
import uri from '@ohos.uri';
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

interface Item {
  name: string,
  url?: string
}

@Entry
@Component
struct Index {
  @State items: Item[] = [
    {
      "name": "加载 RN 页面",
      "url": "pages/RnPageBasic"
    },
    {
      "name": "RN 页面 - 初始化参数",
      "url": "pages/RnPageParam"
    },
    {
      "name": "RN 页面 - bridge",
      "url": "pages/bridge/RnPageBridge"
    },
    {
      "name": "RN 页面 - CustomComponent",
      "url": "pages/RnPageParam"
    }
  ]

  build() {
    Column() {
      Text("RNAbility 功能入口").margin({ bottom: 20 }).onClick(()=>{
        let url = 'https://danjuanfunds.com/funding/000729?a=8'
        let url1 = 'https://danjuanfunds.com/fund/000729?a=0'
        let url2 = 'https://danjuanfunds.com/funding/000729'
        this.changeUrl2RnFundUrl(url)
        this.changeUrl2RnFundUrl(url1)
        this.changeUrl2RnFundUrl(url2)
      })
      Scroll() {
        Column() {
          ForEach(this.items, (item: Item) => {
            Text(item.name)
              .backgroundColor("blue")
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .fontColor('white')
              .width('100%')
              .height(40)
              .borderRadius(40)
              .margin({ top: 16 })
              .onClick(() => {
                router.pushUrl({ url: item.url })
              })
          })
        }
      }
    }
    .height('100%')
    .width('100%')
    .padding({ top: 50, left: 20, right: 20 })

  }

    changeUrl2RnFundUrl(url: string): string {

  if (!url) return ''
  let Uri = new uri.URI(url)
  let path: string = Uri.path ? Uri.path : url

  const regex = /^\/fund(ing)?\/(\d+)$/;

  const match = path.match(regex)
  if (match && match.length) {
    let code = match[2]
    let param =  url.includes("?")? "&fd_code="+code: "?fd_code="+code
    return url.replace(path,"/rn/FundDetail/Product")+param

  }

  return url
}
}

