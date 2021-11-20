using System.Runtime.InteropServices;

namespace NetDll
{
    [StructLayout(LayoutKind.Sequential)]
    public struct ComplexType
    {
        [MarshalAs(UnmanagedType.BStr)]
        public string StringValue;
        public int IntValue;
    }
}