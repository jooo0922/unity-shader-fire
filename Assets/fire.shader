Shader "Custom/fire"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "white" {} // �� ��° �� �ؽ�ó�� �޴� �������̽� �߰�
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
        sampler2D _MainTex2; // �� ��° �� �ؽ�ó�� �޾Ƽ� ������ ����

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2; // �� ��° �ؽ�ó�� ���� �� ����� Quad ���ؽ��� uv ��ǥ��
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

            // �� ��° �ؽ�ó�κ��� ������ texel ���� ������ float4 ������ d
            fixed4 d = tex2D(_MainTex2, float2(IN.uv_MainTex2.x, IN.uv_MainTex2.y - _Time.y)); // �� ��° �� �ؽ�ó�� y�������� ���� �����̵��� �Ϸ��� _Time ���� ����. -> �� �ؽ�ó�� ���Ʒ��� ����ǵ��� ������� �ؽ�ó�� �ڿ������� ���������� �귯���� �ִϸ��̼��� ���� �� ����. 

            // �� �̹����� ������ ������ ���� �ʵ��� (������ ������ ������ ��ó�� �Ⱥ��̴ϱ�!) o.Albedo �� �ƴ�, ������ ������ o.Albedo �� rgb ���� �Ҵ����� ��! p.97 �� Emission ���� ���� ���������� ����!
            //o.Albedo = c.rgb;
            o.Emission = c.rgb * d.rgb; // �� �ؽ����� �ؼ����� rgb �� ���ؼ� o.Emission �� �־���.
            o.Alpha = c.a * d.a; // �� �ؽ����� �ؼ����� alpha ���� ���ؼ� o.Alpha �� �־���.
            // �̷� ������ �� �ؽ�ó�� rgb �̹����� alpha �̹����� ���� �����ָ�, �������� �ʴ� c �ؽ�ó�� �����̴� d �ؽ�ó�� �������鼭 ��ġ ���� �����̴� ���� ȿ���� �� �� ����. -> �ؽ�ó �� ���� ���ϱ� �����̶� ������ ȿ���� ����! 
        }
        ENDCG
    }
    FallBack "Diffuse"
}
