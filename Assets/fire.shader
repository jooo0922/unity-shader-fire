Shader "Custom/fire"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent"} // �� �ؽ��ĸ� �����ϰ� ����� ���� �߰��� �ڵ�.
        LOD 200
        // Cull off // Quad ���� �޽� ��Ҵ� ����Ƽ���� �⺻������ �����̽� �ø��� ����Ǽ� �޸��� ���������� ����. -> Cull off ��ɾ�� �̰Ÿ� �����ϸ� ��� ������ ó����!

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard alpha:fade // �� �ؽ��ĸ� �����ϰ� ����� ���� �߰��� �ڵ�.

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

            // �� �̹����� ������ ������ ���� �ʵ��� (������ ������ ������ ��ó�� �Ⱥ��̴ϱ�!) o.Albedo �� �ƴ�, ������ ������ o.Albedo �� rgb ���� �Ҵ����� ��! p.97 �� Emission ���� ���� ���������� ����!
            //o.Albedo = c.rgb;
            o.Emission = c.rgb;
            
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
