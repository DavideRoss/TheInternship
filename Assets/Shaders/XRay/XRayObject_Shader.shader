// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "XRayObject_Shader"
{
	Properties
	{
		_ASEOutlineWidth( "Outline Width", Float ) = 0
		_XRayPower("XRayPower", Float) = 0
		_XRayColor("XRayColor", Color) = (0,0,0,0)
		_XRayScale("XRayScale", Float) = 0
		_XRayBias("XRayBias", Float) = 0
		_XRayIntensity("XRayIntensity", Float) = 0
		_Colore("Colore", Color) = (1,0,0,0)
		_AccessoriAccessori_MAT_AO("AccessoriAccessori_MAT_AO", 2D) = "white" {}
		_AccessoriAccessori_MAT_Base_Color("AccessoriAccessori_MAT_Base_Color", 2D) = "white" {}
		_AccessoriAccessori_MAT_MG("AccessoriAccessori_MAT_MG", 2D) = "white" {}
		_AccessoriAccessori_MAT_Normal("AccessoriAccessori_MAT_Normal", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0"}
		ZWrite Off
		ZTest Always
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog alpha:fade  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		
		
		
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};
		uniform float _XRayBias;
		uniform float _XRayScale;
		uniform float _XRayPower;
		uniform float4 _XRayColor;
		uniform float _XRayIntensity;
		uniform half _ASEOutlineWidth;
		
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += ( v.normal * _ASEOutlineWidth );
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV5 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode5 = ( _XRayBias + _XRayScale * pow( 1.0 - fresnelNdotV5, _XRayPower ) );
			o.Emission = ( fresnelNode5 * _XRayColor ).rgb;
			o.Alpha = ( fresnelNode5 * (_XRayColor).a * _XRayIntensity );
			o.Normal = float3(0,0,-1);
		}
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite On
		ZTest LEqual
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _AccessoriAccessori_MAT_Normal;
		uniform float4 _AccessoriAccessori_MAT_Normal_ST;
		uniform sampler2D _AccessoriAccessori_MAT_Base_Color;
		uniform float4 _AccessoriAccessori_MAT_Base_Color_ST;
		uniform float4 _Colore;
		uniform sampler2D _AccessoriAccessori_MAT_MG;
		uniform float4 _AccessoriAccessori_MAT_MG_ST;
		uniform sampler2D _AccessoriAccessori_MAT_AO;
		uniform float4 _AccessoriAccessori_MAT_AO_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += 0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_AccessoriAccessori_MAT_Normal = i.uv_texcoord * _AccessoriAccessori_MAT_Normal_ST.xy + _AccessoriAccessori_MAT_Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _AccessoriAccessori_MAT_Normal, uv_AccessoriAccessori_MAT_Normal ) );
			float2 uv_AccessoriAccessori_MAT_Base_Color = i.uv_texcoord * _AccessoriAccessori_MAT_Base_Color_ST.xy + _AccessoriAccessori_MAT_Base_Color_ST.zw;
			float4 tex2DNode19 = tex2D( _AccessoriAccessori_MAT_Base_Color, uv_AccessoriAccessori_MAT_Base_Color );
			o.Albedo = tex2DNode19.rgb;
			float4 lerpResult15 = lerp( float4( 0,0,0,0 ) , _Colore , tex2DNode19);
			o.Emission = lerpResult15.rgb;
			float2 uv_AccessoriAccessori_MAT_MG = i.uv_texcoord * _AccessoriAccessori_MAT_MG_ST.xy + _AccessoriAccessori_MAT_MG_ST.zw;
			float4 tex2DNode20 = tex2D( _AccessoriAccessori_MAT_MG, uv_AccessoriAccessori_MAT_MG );
			o.Metallic = tex2DNode20.r;
			o.Smoothness = tex2DNode20.g;
			float2 uv_AccessoriAccessori_MAT_AO = i.uv_texcoord * _AccessoriAccessori_MAT_AO_ST.xy + _AccessoriAccessori_MAT_AO_ST.zw;
			o.Occlusion = tex2D( _AccessoriAccessori_MAT_AO, uv_AccessoriAccessori_MAT_AO ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
271;73;1255;603;2445.774;653.8352;2.402864;True;False
Node;AmplifyShaderEditor.RangedFloatNode;1;-1632,496;Float;False;Property;_XRayPower;XRayPower;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1680,416;Float;False;Property;_XRayScale;XRayScale;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1664,304;Float;False;Property;_XRayBias;XRayBias;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-1552,624;Float;False;Property;_XRayColor;XRayColor;1;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;7;-1280,672;Float;False;FLOAT;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;5;-1440,352;Float;True;Standard;TangentNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1264,848;Float;False;Property;_XRayIntensity;XRayIntensity;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-976,352;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;19;-1152,-336;Float;True;Property;_AccessoriAccessori_MAT_Base_Color;AccessoriAccessori_MAT_Base_Color;7;0;Create;True;0;0;False;0;2bbdbe3461573f4429676862f49b0234;2bbdbe3461573f4429676862f49b0234;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1072,560;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-1040,-672;Float;False;Property;_Colore;Colore;5;0;Create;True;0;0;False;0;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;15;-310.4861,-467.7755;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OutlineNode;12;-768,336;Float;False;0;True;Transparent;2;7;Back;3;0;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;21;-749.9102,27.93347;Float;True;Property;_AccessoriAccessori_MAT_Normal;AccessoriAccessori_MAT_Normal;9;0;Create;True;0;0;False;0;dbd3d7dc4565845469660ca9b4835511;dbd3d7dc4565845469660ca9b4835511;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-1152,-528;Float;True;Property;_AccessoriAccessori_MAT_AO;AccessoriAccessori_MAT_AO;6;0;Create;True;0;0;False;0;9e3a65248a4606740bb9eda3df8514ef;9e3a65248a4606740bb9eda3df8514ef;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;20;-1136,-124.9723;Float;True;Property;_AccessoriAccessori_MAT_MG;AccessoriAccessori_MAT_MG;8;0;Create;True;0;0;False;0;9fcd2d8791d3e574b8720a08dde94f86;9fcd2d8791d3e574b8720a08dde94f86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;45.8716,-194.9543;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;XRayObject_Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;4;0
WireConnection;5;1;3;0
WireConnection;5;2;2;0
WireConnection;5;3;1;0
WireConnection;9;0;5;0
WireConnection;9;1;4;0
WireConnection;10;0;5;0
WireConnection;10;1;7;0
WireConnection;10;2;6;0
WireConnection;15;1;11;0
WireConnection;15;2;19;0
WireConnection;12;0;9;0
WireConnection;12;2;10;0
WireConnection;0;0;19;0
WireConnection;0;1;21;0
WireConnection;0;2;15;0
WireConnection;0;3;20;1
WireConnection;0;4;20;2
WireConnection;0;5;18;0
WireConnection;0;11;12;0
ASEEND*/
//CHKSM=79F6DC7B8812FBC59FC1B56602947861199BC502