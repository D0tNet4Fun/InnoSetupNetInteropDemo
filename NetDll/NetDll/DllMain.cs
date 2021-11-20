using System.Runtime.InteropServices;

namespace NetDll
{
    public class DllMain
    {
        [DllExport(CallingConvention.StdCall)]
        public static void UpdateInt(ref int input)
        {
            input++;
        }
    }
}