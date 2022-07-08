require "import"
import "android.widget.*"
import "android.view.*"
require "lua/xaLdoc"
xauis={
  LinearLayout;
  orientation="vertical";
  layout_width="fill";
  layout_height="fill";
  {
    TextView;
    layout_height="fill";
    layout_width="fill";
    id="tv1";
    textColor="#000000";
  };
};
function main(...)
  activity.setTheme(android.R.style.Theme_DeviceDefault_Light)
  activity.setContentView(xauis)
  local File_information=...
  finfo=xaLdoc.xaLdocs(File_information)
  tv1.text=finfo
  --print(xaLdoc.xaLdocs(File_information))
end
