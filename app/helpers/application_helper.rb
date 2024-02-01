module ApplicationHelper
  def page_title(page_title = '')
    base_title = '...次、どこ行く？'

    page_title.empty? ? base_title : page_title + ' | ' + base_title
  end

  def default_meta_tags
    {
      site: '...次、どこ行く？',
      title: '...次、どこ行く？',
      reverse: true,
      charset: 'utf-8',
      description: 'ドライブの途中で次の行き先に困ったとき、その場の気分に近い目的地を検索できるサービスです。',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      # X用の設定
      twitter: {
        card: 'summary_large_image', # Xで表示する場合は大きいカードにする
        image: image_url('ogp.png')
      }
    }
  end
end
