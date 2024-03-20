import { RequestContext } from "@vercel/edge";
import Mustache from "mustache";
import {
  AppConfigEntity,
  AppConfigsApi,
  Configuration,
} from "myorderapp-square-fetch";

export const config = {
  matcher: ["/:merchantIdOrPath*", "/manifest.json"],
};

export default async function middleware(
  request: Request,
  _event: RequestContext
) {
  const url = new URL(request.url);
  const pathComponents = url.pathname.split("/");
  const merchantIdOrPath = pathComponents[1];
  const baseUrl = `${url.protocol}//${url.host}/${merchantIdOrPath}`;

  if (
    (/\.\w+$/.test(url.pathname) ||
      url.pathname.startsWith("/assets/") ||
      url.pathname.includes("firebase")) &&
    !url.pathname.endsWith("manifest.json")
  ) {
    return fetch(request);
  }

  let appConfig: AppConfigEntity | undefined = undefined;

  try {
    const response = await new AppConfigsApi(
      new Configuration({
        apiKey: process.env.MYORDERAPP_SQUARE_API_KEY!,
        basePath: process.env.MYORDERAPP_SQUARE_API_BASE_PATH!,
      })
    ).getAppConfig({
      merchantIdOrPath,
    });
    appConfig = response;
  } catch (error) {
    console.log(error);
  }

  if (url.pathname.endsWith("manifest.json")) {
    let manifestTemplate = `{
      {{#background_color}}
      "background_color": "{{background_color}}",
      {{/background_color}}
      {{#theme_color}}
      "theme_color": "{{theme_color}}",
      {{/theme_color}}
      {{#description}}
      "description": "{{description}}",
      {{/description}}
      "orientation": "portrait-primary",
      "prefer_related_applications": {{prefer_related_applications}},
      {{#prefer_related_applications}}
      "related_applications": [
          {{#play_id}}
          {
              "platform": "play",
              "url": "{{{play_url}}}",
              "id": "{{play_id}}"
          }
          {{/play_id}}
          {{#itunes_id}},
          {
              "platform": "itunes",
              "url": "{{{itunes_url}}}",
              "id": "{{itunes_id}}"
          }
          {{/itunes_id}}
      ],
      {{/prefer_related_applications}}
      {{#icon_src}}
      "icons": [
        {
          "src": "{{{icon_src}}}",
          "type": "{{{icon_type}}}",
          {{#icon_size}}
          "sizes": "{{icon_size}}",
          {{/icon_size}}
          "purpose": "any"
      }
    ],
      {{/icon_src}}
      "name": "{{name}}",
      "short_name": "{{short_name}}",
      "start_url": "{{{start_url}}}",
      "display": "standalone"
}`;

    let manifestData = Mustache.render(manifestTemplate, {
      name: appConfig?.title ?? appConfig?.name ?? "MyOrderApp",
      short_name: appConfig?.name ?? "MOA",
      description: appConfig?.description ?? "Create an order for pickup",
      background_color: appConfig?.seedColor ?? "#ffffff",
      theme_color: appConfig?.seedColor ?? "#ffffff",
      start_url: `/${merchantIdOrPath}`,
      icon_src: appConfig?.iconFileFullUrl,
      icon_type: appConfig?.iconFileContentType,
      icon_size: appConfig?.iconFileSize,
      prefer_related_applications:
        appConfig?.preferRelatedApplications ?? false,
      play_url: appConfig?.playAppUrl,
      play_id: appConfig?.playAppId,
      itunes_url: appConfig?.itunesUrl,
      itunes_id: appConfig?.itunesId,
    });

    return new Response(manifestData, {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  } else {
    const body = await fetch(new URL(`/index.html`, request.url)).then((res) =>
      res.text()
    );
    const templatedBody = Mustache.render(body, {
      title: appConfig?.title ?? appConfig?.name ?? "MyOrderApp",
      canonical_url: baseUrl,
      favicon_url: appConfig?.iconFileFullUrl,
      icon_url: appConfig?.iconFileContentType,
      manifest_url: `/${merchantIdOrPath}/manifest.json`,
      itunes_id: appConfig?.itunesId,
      meta: {
        description: appConfig?.description ?? "Create an order for pickup",
        og: {
          title: appConfig?.title ?? appConfig?.name ?? "MyOrderApp",
          description: appConfig?.description ?? "Create an order for pickup",
          url: baseUrl,
          site_name: appConfig?.name ?? "MyOrderApp",
          image: appConfig?.bannerFileFullUrl,
        },
        twitter: {
          site: baseUrl,
          title: appConfig?.title ?? appConfig?.name ?? "MyOrderApp",
          description: appConfig?.description ?? "Create an order for pickup",
          image: appConfig?.bannerFileFullUrl,
        },
      },
    });

    return new Response(templatedBody, {
      status: 200,
      headers: { "content-type": "text/html" },
    });
  }
}
